Date: Sat, 24 Nov 2001 16:32:01 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again with the firewire
In-Reply-To: <20011124122119.19280@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.40.0111241629360.10788-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Also, I've found that plugging in a FireWire device, then unplugging it
before doing anything with it (but after waiting ~30 seconds, long enough
for the kernel to see the plug event and try to load the driver) will
cause a system freeze. If I do something with the device (try to mount it
or something), then it's fine, the unplug goes off without a hitch, and
the system continues running.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
