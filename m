Message-ID: <3EC49817.9080106@elsoft.ch>
Date: Fri, 16 May 2003 09:49:43 +0200
From: =?ISO-8859-1?Q?=22David_M=FCller_=28ELSOFT_AG=29=22?= <d.mueller@elsoft.ch>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Tom Guilliams <tguilliams@sbs.com>,
	Linux PPC Embedded List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc_2_4_devel: 2.4.20 rc2 - where's pImage build?
References: <1052969438.14900.8.camel@aurora.rr.com> <20030515185953.GC11565@ip68-0-152-218.tc.ph.cox.net>
In-Reply-To: <20030515185953.GC11565@ip68-0-152-218.tc.ph.cox.net>
Content-Type: multipart/mixed;
 boundary="------------020903090002050902050608"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------020903090002050902050608
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello

Tom Rini wrote:
> On Wed, May 14, 2003 at 08:30:38PM -0700, Tom Guilliams wrote:
>
>
>>Anyone know why the BOOT_TARGET define for "pImage" in arch/ppc/Makefile
>>was taken out?  Are we not going to support the build rule for
>>U-Boot/PPCBoot anymore other than building it manually (gzip vmlinux
>>then use "mkimage").
>
>
> Probably a bad merge.  Wasn't there a patch / request a while back to
> update things (or just add it for 2.5?  I forget) that never got back to
> me.  Anyhow, I'll try and put this back next week (finals week this
> week) and see if I can get it up to Marcelo, provided someone else can
> verify that it works right.
>

This patch adds support for PPCBoot and U-Boot (PPCBoot's successor).


Dave

--------------020903090002050902050608
Content-Type: application/octet-stream;
 name="ppcboot_u-boot.patch.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="ppcboot_u-boot.patch.bz2"

QlpoOTFBWSZTWUbbdPYAAZpfgCQwff///3//337/79/6UAQAHgqgAAJRENTJpT9A0mU8pnpN
Noo9TT1PKeKY1H6kAHplMaJ6gOGhk00NMjQ0yMgyMjQyAxNGTQBkyMQxw0MmmhpkaGmRkGRk
aGQGJoyaAMmRiGOGhk00NMjQ0yMgyMjQyAxNGTQBkyMQwkSTQCGkxNMCKPKbSeoB6mh6npNH
qekPUGTaj0htSYCyQFWuw+gdoo155GDN38+GC9iNkTLPDb2b5qqOpMa1nc/kzuqcsLa1mcgP
D9QStJcMtYvAr9+k5aYTIif6R28eQ8ZDxapx5fXZyuOLzBaI99/yYpiWR7dY739BYexzPqqq
sPlT+o5SA0WlyFMuL+S4Gcu0qbubIKgvIwro3hINp2GMZAurnuyT8RwiKPQDMpeGJXwKkJiI
AzA85c1IaRPMIxQ1rjZzjqht2ZyOF8uEiwwdc9sjdS0ylsfEogHc09GFxAknQVR4rFcacufT
AGoVawqGGZV6WMaLPyNhg1DpHx1tgvWVSKoPppwe5Ae1mb8bBftrCMcZEtAoKCoYgZyH2HMc
pQjSFI4VsBKQND9YQjWNOUBdpfJpLwMdwZClFfRy+icOIiIheS7M/I8z2dliCtYWhcCkoDrO
sYYy4CDgGL4aBp+d0GrRICIibXpIUBDHEKa7Ssg54HQBJcNAoVNUnAUkyIHNEFlk6Zu8rJDU
aBxL5K68mg4jvdvAFiiuUBIxu/EZAJTGwAYF8FPSPqIuBoPBZ3IY3+nUfz7K10V7H9ybbbRQ
QUiKaqF6j2PvBmIvg8MAoSIVH6hHEhoPD79i7VYE41Ea1lanaQund29NHehX43b4jOxA0dy3
1FlpQV8IjpK0NqrjyrAg3bCzFuKvbWYi7e2nlW2ZVbHZiqDLkIMfcR2gC9xsIaDz8pL/KTzE
jvTUsw2NjYz/pnLItRPmkR4F54DJIJUBUhXIUFiGKuWB1kwykFCkiMUAUC9yVlUlWrzwOiwi
s9N8AisYDIPXxkywOhhgBYgwJqWRUFtyRP+6gqtzmUw1TzIGjOALnK5OnA7kJsfibpJ9ukNp
+9t5sKRFhapExaRDW1NG3AI1C8zCvpWKZ/BAF+oKsgKm/ARmJnCayFrQspMimtgWKR5Y1SRX
ZpXy0NtMYmMYNpg000j1SsNquKA8SMFQgsMN9+OQzfig2jKMZxBMLxWwC41rPGg5NJTM6UjU
gaYveNlYMGk2IIJUrReuvQcyF7WqJgs63jWhTLzjVCFgDynUHIXVWGSv4NcjcE9FBBsYbk0V
WkZ8kW2Tv3Muc2c7BXDAKawsKUDkVLLAUBZ8++gJZNy3G0xHEnrXAkZDNK5cbHEMaDnXAkZi
pGfi8pbWsbByUC6j6D/xdyRThQkEbbdPYA==
--------------020903090002050902050608--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
