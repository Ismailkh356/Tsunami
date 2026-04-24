CC = gcc
CFLAGS = -Wall -Wextra -O2 -pthread -D_DEFAULT_SOURCE
LDFLAGS = -lnghttp2 -lssl -lcrypto -pthread

TARGET = tsunami
SOURCES = tsunami.c

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) -o $(TARGET) $(SOURCES) $(LDFLAGS)

clean:
	rm -f $(TARGET) *.o

# Works on standard Linux (/usr/local/bin) and Termux ($$PREFIX/bin)
install:
	@if [ -d "$$PREFIX/bin" ]; then \
		cp $(TARGET) "$$PREFIX/bin/$(TARGET)"; \
		echo "Installed to $$PREFIX/bin/$(TARGET) (Termux)"; \
	else \
		cp $(TARGET) /usr/local/bin/$(TARGET); \
		echo "Installed to /usr/local/bin/$(TARGET)"; \
	fi

uninstall:
	rm -f /usr/local/bin/$(TARGET) "$${PREFIX}/bin/$(TARGET)"

.PHONY: all clean install uninstall
