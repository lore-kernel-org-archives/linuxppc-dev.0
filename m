From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Benjamin Herrenschmidt <bh40@calva.net>
Subject: patch for aty128fb.c that hopefully will work on both Rage128 and Rage128Pro
Date: Sun, 19 Mar 2000 17:40:09 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
References: <20000318230212.008930@192.168.1.10>
In-Reply-To: <20000318230212.008930@192.168.1.10>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00031917463200.00638@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Ben,

I looked and the aty128fb.c does not do anything with the MCLK value so I never
bothered to calculate it.

So assuming OF sets the PLL registers properly (and it did on my B+W G3 rev2
and my brand new G4 with Rage128Pro), this patch calculates the XCLK and reads
the reference divider for the VCLK but does not set X_MPLL_REF_FB_DIV at all.

The patch is attached.

By the way this patch works fine on my B+W G3, let's hope it will work fine for
you and others.  If so, I will create a similar patch for xf400 and give
that to Kostas to submit to xfree86.org.

Kevin



--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="rage128.patch.gz"
Content-Disposition: attachment; filename="rage128.patch.gz"
Content-Transfer-Encoding: base64

H4sICCdX1TgAA3JhZ2UxMjgucGF0Y2gArVVtb9MwEP7c/IpDSJC0aec43VZWMQYblRDrNjGEKiFk
ubGzWk2TKHa6AuK/c3a6ai/t+EIVqUn83Ntzz1263S6ISi1lpfeWSshij5ufER2k017Sy7g2rWtu
YMwriAZA4yPSP6J9oIQQr9Pp7DRtXdd5Y/UGooMjenjUjxurkxPo0ojG4QF03H+8DycnHmjDjUpg
WSgBjKlcGQ8af8yohcpvtK9NVScG0ikepwVrTqFtHwIPfnsdr/NSpSBkqnIpfMbK4lZWZcJY4HUA
9tqgcm0kF1CkwMHwaSYhK4p5XQLXul5IuBzBjGsoq6KUVfYTtDRQl9Yaf2Ym4er8HCp5o9BPpYHn
Amot7YmqYMmzWmowhTOz6Mnp+ee18frQWlQylZXMEwlCWeI2lu09WwNAHVNYsUWZZQyxDAtG4HBz
kmRzluQm27y5WIUwbp5yrW6weLgqtDlTy2tpvv+At/CbhBCFQEPohzAIIQ7hAN/QP85qzc77hoMv
H0eQZEUyB6WBvtkn4KscPSujLXERmc9+BS5XZ2UrMjMUCc8ywJQxO1jU2sBU4mVupcwx0D6MZ78c
lu4Te9vY2951j5MC+8Jzo3uiME3oty7yELaBSksMSgJB6JiQ4W4QX1lPiLEgC3tCK56jkFgmGL73
J2yMHWZIARt9YGefvgXO+YbyR2hsLzu9+HoewCsgq0OHvbAh/adxLIKQ0YiQAI6PYeDAY8TuBlt4
sE78cX02JWtcFXUurI3vU2jb6O2drAYh8tlqtfwxgu4pZFPej2BXOJvbnVofcHB1x5clC/O+/8zG
768/O4cvZaZlMwmeGwcUztfLs0tY8LlEWaBHIxclisjY4ZvivFuFOCiOtP9iZ0ketP4lovXOiePw
0O6cA4q7x66cnc7vtLPN+RNdtbAUGuMdFDnoAgco4ZXQ71z+XtdupGhT82QycXX34JRnSZ1xIzfL
pgcjtcIN9FrbMQKkmuve8yzc68q2XB82jazi6R0XfRpGsSXjkIQRdWw0YWxntdk+C6ETZT/pJ5FE
nWzwlpHbShlZlwIL8t1CHmLpruldl/1/lBP6zYVKvYdKus/os5xZsW8jaz1QZBWJvnBd1RybiV+D
hT1pdvPD0I9dpAo/S7dKmJlbTYPhMzAhSweL6dD7C7+liGqFBwAA

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
