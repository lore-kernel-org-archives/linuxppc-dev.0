Date: Wed, 29 Mar 2000 18:47:18 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LinuxPPC and Pismo Powerbook
Message-Id: <20000329184718.027924@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Mar 29, 2000, Olaf Hering <olh@suse.de> wrote:

>I had never problems with my faked system folder, I move it around, to
>CDs, to netatalk servers and where ever I want. This can be a "feature"
>of OS9 that it doesn't remove the information, I don't know.
>
>What makes this blessing so special??

The "blessing" is a combination of two things:

 - The directory ID of the "blessed" folder is written somewhere in the
disk catalog (I think in the MDB, I don't remember for sure)

 - Valid boot blocs are written to bloc 0 and 1 of the volume

OF may still be able to boot if the bootblocs are not present (but miBoot
can't).

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
