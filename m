Message-ID: <38E5B7B3.1597F706@execpc.com>
Date: Sat, 01 Apr 2000 02:47:47 -0600
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Startup Disk for linux
Content-Type: multipart/mixed;
 boundary="------------F290382AA9A2ED356B1F5474"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------F290382AA9A2ED356B1F5474
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

I have written a simple beginning to a Startup Disk util for linux, i call
PRAMBoot.  It has 3 boot partition options hardcoded, which should be modified
to fit your system.  I have them set up to boot MacOS, linux, and a safe backup
linux.  The location code is a 16 bit representation of the location of the boot
partition.  I'm not sure what they mean, but running this program with no params
will read what it currently is set to.  This works with my PDQ, and i dont know
if it will work with any others.  Requires nvram support.

I dont know if anything like this already exists.
I wrote this because i got tired of having to modify my miboot partition to boot
macos.

Also available at http://www.execpc.com/~jpgarcia

--
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

"Ask yourself, Why do you seek the developer kernel?  Is it for its glory,
 or for yours?"
--------------F290382AA9A2ED356B1F5474
Content-Type: application/x-gzip;
 name="pramboot.c.gz"
Content-Disposition: inline;
 filename="pramboot.c.gz"
Content-Transfer-Encoding: base64

H4sICKy25TgAA3ByYW1ib290LmMAxVVhb9s2EP0c/YqLizSSocVy1yDFEhdw6nTwkMSBk6Lb
uiKgJcoiIpEGSdkW0vz33VFS7LobtvXLDMMWj/feHd/dUb0u3EyHV+dK2aPYgy4M4bYylhcw
EuYBDg3PeWyVPoRUabgUsly7p0IQBErDtSGYHwfwizJ8kcENy5kU8DPTsWDwKooicnivOa+R
KhGpiJkVSgKTCSTCWC1mJRmOyPVawYppzaStjgDuMg6stBlChQGJQTU3CyWNmOU1I5MVJKxg
cx6CkLGSSy4FlzEulSZCZTOuQfI5Bl1yWIoZN2AzZqFgFag4LjUGqlQJGcN99AajSk0EZDSZ
KvMEHqRaEduKgDbDZBLFDWXc87wXGDgvEw5nxiZCHWVvt0xpLG1OJq/XBcwvFfNSuziGOzSa
HSF+F0xb4bQ5AfwpKpiVIrd4MBiPLiDRdALEvEh4KiSHq+G7ye3eXrRGnU+IaEPQf73teDm+
/vBr48h3HI+3HW+H7y8avxRcbmklUFmwHBsjAQYmNgISvhQxpxzHI+iHW3THIZWozK2Qc8ob
qd5Ex+1BsYIZbcx4rlZ04lYQRvV0WjaJnE8md8PRaIq59H88ebNJcPx7m+ArohSFawtDmvI1
i21euSJtiRm26YokdE03K1HtBKuuJHpTF2GVV1+H/3B7Px75VQAAvl+9jNZpGkVBDwP38f/Z
72Y4vRvfjSfX5Or8ULiUUPjxPE9IC17BhPTpicUhxBnT0O2yZeA9egDGYl/GUGJLzyUKjJlo
CzOcr0+fB4+uwE+nGz9ikcs0OfXQRouVyPP7lRaWD6LamPosftsPPMoAF/s4YHGx8NnyU/9z
2DEs5Z0gePTqFLsUaUBVP20sW4T92vbEc2zVb6lyuhC+4XKt9t/JChYrs0X2F8jmdPubrcYb
jT6JAgNQCy79Tg8L3pNLzYpOCJP76WhyfflbEJxFz/QLrrXSfucdTbc8tA4IW7igPQJfC+v3
gzaHOh74eAr+4KKGz70aQhTAGUTe3pcvOAUsafZ9qnk3eEn6hK6DA9gfNA+7GV3Qn0PToPzL
jBYaeyH1O1OE/QS1q1O6ZjfcliLxowbzT3p9nP4PermCfr9gBP8OwT5qZfmzYtRh7U60Pohe
r+EHOMfbAm+5A4Evt/aWOxCd0LV72FwUbhGEm+ugNjhalLseDTdnwVfxwXe2P2SdQTscjb+b
pV2Aew//HcJdGLuIKxajcRux41BKer/J1sXpRc3y5P0JoxzOvyMIAAA=
--------------F290382AA9A2ED356B1F5474--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
