Date: Wed, 28 Jul 1999 19:31:22 -0500 (CDT)
From: "Andre M. Hedrick" <hedrick@Astro.Dyer.Vanderbilt.Edu>
To: Martin Mares <mj@ucw.cz>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        mlan@cpu.lu, drow@false.org
Subject: Re: Trying a Promise Ultra/66 on powerpc
In-Reply-To: <19990728100747.B331@albireo.ucw.cz>
Message-ID: <Pine.LNX.3.96.990728192813.22678A-100000@Astro.Dyer.Vanderbilt.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 28 Jul 1999, Martin Mares wrote:

>    Yes. Take a look at arch/i386/kernel/bios32.c, the pcibios_fixup_devices
> function.

When you make it let me know and I will add it my kernel directory, being
IDE related.  The "fortuna" patches have the ide-pmac.c fixed finally.
This was the current holdup for the 2.2.X ide updates.

http://linux.kernel.org/pub/linux/kernel/people/hedrick



Andre Hedrick
The Linux IDE guy


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
