Date: Sun, 20 Jan 2002 13:48:27 -0600
From: "Joseph P. Garcia" <jpgarcia@execpc.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: mediabay hotswap, tun naming patches (2.4)
Message-Id: <20020120134827.15bedeb6.jpgarcia@execpc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Sun__20_Jan_2002_13:48:27_-0600_102de378"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.

--Multipart_Sun__20_Jan_2002_13:48:27_-0600_102de378
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Greetings.

It's been a while.  Got a few patches that have been languishing in my system for too long.

One changes the mediabay ide_register call to an explicit call to the pmac_ide call that it needs, at least on a wallstreet.  Without this, an ide mediabay cannot be inserted post-boot.

The second patch changes the behavior of the tun device so that devices are not required to have a numerical value after their name.  I have yet to figure out how to tell MOL to assign a numerical value and pass tun a % like the kernel wants.  Just made it so that if there is no numerical value, then that tun device is the only one of its kind.  ( "mol" = one iface, while mol% = many ifaces, (or maybe "mol0" and "mol1" are explicit different ones, not same as "mol%" ifaces.)).  I suppose would be unnessesary/undesired when MOL gets updated to support ___% registration. (or i figure out how to use it :)

Thanks.

PS, I still use my wallstreet, and haven't found out why adb crashes.  rtc and nvram also appear to break at that moment, but pmu (battery support, etc) is fine.  still not sure if its a pure software issue or if hardware got confused.

--
Joseph P. Garcia
http://www.lycestra.com/

--Multipart_Sun__20_Jan_2002_13:48:27_-0600_102de378
Content-Type: application/x-gzip;
 name="hotswapmediabay.patch.gz"
Content-Disposition: attachment;
 filename="hotswapmediabay.patch.gz"
Content-Transfer-Encoding: base64

H4sICHsaSzwAA2hvdHN3YXBtZWRpYWJheS5wYXRjaAB9Udtum0AUfIavOFKlCpuLAV/qOnHk5tIq
jRtH6uV1hWExq5iF7i7BVtV/72HxLW2TFyRmzpmZM+u6LqwZrzZu6A28YFwKOvAKwVa9RLAnKmQv
j2LGVSGzXk4TFi2jrRcb37IKPkccgncQjCbD95NhH0LfD03btv/Re13qa8W1VOhD0J+E4wlqaqnZ
DNz+wBmBjd8ggNnMhDeMx+sqoXAeybz3SLfrSKwKL7s4pbR/L0qW/8XLvGpwm6UJTeFqcf/x9hO5
nN+R65sf5Pb6xrT/3mAJ1Rt0o6jg8FSwBAgp8RrTbr4EBwjjTJGsZikpC6GkldVE0JUkCrpZ7eiJ
AgH8TyIV6SEHTuFYiXULY0fQZeJn5wyzUJ6w1ITmjtPAD18+XJGHy8XizgSpIsViaNbyJeGFYumW
yDWlpSWVqGIFeHMLtCyjArqSrlNHL9UZ5ejV9D0c9Z0x2MPR2AlC3bhhGPhO7oViOW5NwT87Yo0x
RQxdq7LFWQqW5uIEK0noBs7B78Av00bSOJaS1e28oaNVssQ7LQzhGnvxg8BU14R7TGL/B/VlJKkD
vgOH6baxVvSFV3mLb2GdtN6BZ3LPKdS+/z6f70Wz2kMLjHNieKTijJWSql3aij/youY7+rV7MJ1O
tbc6lCKorHJq7aDfL7Q7nYIbNP3+AfLjc3jJAwAA

--Multipart_Sun__20_Jan_2002_13:48:27_-0600_102de378
Content-Type: application/x-gzip;
 name="tun_naming.patch.gz"
Content-Disposition: attachment;
 filename="tun_naming.patch.gz"
Content-Transfer-Encoding: base64

H4sICGcZSzwAA3R1bl9uYW1pbmcucGF0Y2gAnZJRa9swEMef7U/xb6FNXFuy5CZjTcjIHtqREUKh
dAzGMI4txx6pZGQ5NFv73SfZdJQ9bdXDSTr97n+nk4q6LEF0dwvyFZTG9U4qLQrn3deyeyQJnVA+
JY0WCdkKyZypEsa4HYwqXf+IpTBxbqPiQhxo/i9x5PPtJ/5XnE8IeWtO7y4z2KgDOAObzvhkxhhc
gB+G4VsLei3K+Wx6NbtMBtHlEmT67ip6j9BNfILl0oeHC+RVprPcCN1GUBpS4fTs9JUXVjLb72lP
x9Y2WKA1Oq/0WGYPIsLobBTMfeLVJcYNzs+t/ca/42SBUTHC09ML3YTJAAeBpT0tTKclyPVq8+Xj
eu6H/yPwy+JAKxtdS1OOt10ZtfVPofplELnCgnnPONE0te1Jd8Kk22PqznoKiwU29+t1AKfmuSTN
cWxJ8mG4mIOcyEupbFB87u2f8jc3q/W1O3n2YdsTXwx9XZU4qg5SiALqILR9E4ZmL7JW2H62CmX9
CFO5zc7+D1M9UEr935WC2q3dAgAA

--Multipart_Sun__20_Jan_2002_13:48:27_-0600_102de378--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
