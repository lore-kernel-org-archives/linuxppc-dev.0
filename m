Date: Tue, 23 Dec 2003 17:06:55 +0100
From: ARIBAUD Albert <a.aribaud@giat-industries.fr>
Subject: RE: Embedded initrd with static programs
To: linuxppc-embedded@lists.linuxppc.org
Message-id: <158EF4B20EA8C84D9DC71A55216D2E1C066C71@csy-exchange1.giat.intra>
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> So basically I need the other two programs also statically
> compiled, does anyone of any idea on how I would go about
> this??

Mybe I am missing something, but why not use the dynamically
linked versions and include the necessary libraries in the
initial ramdisk?

Albert.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
