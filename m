From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: patch to get latest XFree 4.0 snapshot (xf3918) to work on ppc with r128
Date: Thu, 24 Feb 2000 10:06:50 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
MIME-Version: 1.0
Message-Id: <00022410155400.20404@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi,

Yesterday the last Xfree4.0 snapshot was released (xf3.9.18).  Because of all
of the hard work of Kostas integrating powerpc changes into the official xf 4.0
tree, the xf3918 snapshot almost builds out of the box and provides wonderful
Rage128 acceleration at 16bpp and 32bpp.

The only changes needed were to xfree86.cf to add the r128 module to those being
built on powerpc and a patch to lnxResource.c provided by Kostas.

Will someone who understands PCI addressing and memory-mapped io, please look at
xc/programs/Xserver/hw/xfree86/os-support/linux/lnxResource.c and help us
figure out what really needs to be done here so that xf 4.0 final will build
completely out of the box.

Anyway,  I have attached the small patch needed.

With this patch XFree86 Xserver with full rage 128 acceleration is working
nicely on my B+W G3 right now with any recent kernel 2.2.15 kernel (ie. one
that includes Anthony's latest aty128fb.c kernel video driver).

Thanks Kostas and Anthony for your great work!

If anyone is interested, after some more testing, I will create a binary that
can be installed over XFree 3.3.X.  Just let me know if interested.

Thanks,

Kevin

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: application/x-gzip;
  name="xf3918_r128.diff.gz"
Content-Disposition: attachment; filename="xf3918_r128.diff.gz"
Content-Transfer-Encoding: base64

H4sICKdItTgAA3hmMzkxOF9yMTI4LmRpZmYAzVdbb+JGFH6Of8VZrVSRGGJDCBCiqoEsRGiTDUrS
loeVIsc+A6PYHjQzBkft/vc9Y5trQtNWdNV5YOzxuX/nMlQqFUh9xxcx42PHZ07KJGKrceyz46nE
2cHDJIE+PkG1CdVa2z1r10+h5rquZdv2Ls4lU60ObqvtNtu1as50cQGVk2qr3ATbbC24uLDAOYJh
IhGGlwMIJJ+hVKAmIgkDGAtgXCoNR44FH4GzOEAGo36rcenJ4FNObL4AnfMYtz8dRGMPxiGPNaiT
GZdjBMUV+FzKRIFWGI/hq1U5oKUlD5Do/AmfKmBPAc5gRtxGYi/V0lvXaO/ikNVaK2P7atnwznpT
MvmCccAZPRS7Vckxmkoxll6knJFCSbTOZL6IuSNURSXTqZDaIWeT1Anj9A6VSKSPx/4mkgaUs/ZJ
q316toHkv5e/Jbp+2j49WeFdPXXLDbDN1mpmgJslUScyNtu5Bd/IS/sjhpwVOAalx8epmKOc+o+P
h5Zt2RLVUEvLTlmr0fH933kciLnqSxHd3pdmggdE9Ucec8qnvheGT57/DAS2FkBvYg5eEJAUxQlz
wcwZRBgJ+QJq6vloUszOLTOajGXwM3z59fr6fHl+58WUQdL8nhujzPFd58tVr5Sdld2ym7JilSk+
vdS/wagbCv/5cCnFiM28CAIieRDXXOkSHZfhp1wKhexwKf7vOzNwbrc8cY7eMq4wbCAKuxbU7ziy
pP+nfmyjbX/bxnOgvG6i3kH1/wXLjw3Wq/QnGUWQVmHZCNVbIaFUGo1G8Pn+YS3X11QtqIrO9Srx
/NDjEegJAhMmB03ueRI91V5wLDnd1C0WVPKXMxOdA5O5jbr7DBNBTT0vv02my3WmXp8WAIXS01zE
JtN/u+qAFwcgyA4JmGqMFX1ScHd7c78piq2LytA5UC9KYwTdwe0mbXVl60mBZGZr9YrOqjfdHfYy
9FeM9JIzUgvzklBnBdkZDi4hn5F5cW5w4zo3bnJfk9PhX/Ozdf6F2RM+nmQOZthAqZikekIgPiHw
2A+TAINfDl+BJpGhxNjHNgxijSHU6253BJ2rIalGXy0Ind29KU8RimhmU4Z5hpabrkW4WZgKuzrP
2V4K9ZXkNAOLdvyP5LNC/n4azWv5eQzLqxzd0gF/Ah10uVD5U09pHnkag704V+R6eZXpO9XvRx+u
9OEP0MdW+t4L7/6GeV4wc6T5/RyLeQzmjqWoSrM+uygkwjvv5WujHYaCxv9T+LK4K+eilIjQ9Eli
j8BTpmlIVUwCtVa72zVX3Z5de0mhYuTQZSVv2OrtyWOGHN13Q4V0EaQHKYWENv0r0PBCd0yYhp5m
QkZ0O5zSrTi7dIsAgSTihw/WdyqwK6PFDAAA

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
