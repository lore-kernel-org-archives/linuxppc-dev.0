Message-Id: <9911111606.AA37454@marc.watson.ibm.com>
To: Ethan Benson <erbenson@alaska.net>
Cc: "Florent" <flobo@iname.com>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Re : Newworld OF boot 
In-Reply-To: Message from Ethan Benson <erbenson@alaska.net>
   of "Thu, 11 Nov 1999 07:01:27 -0900." <v04210104b45097a0f485@[192.168.0.1]>
Date: Thu, 11 Nov 1999 11:06:51 -0500
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Ethan Benson writes:

Ethan> because you have to recompile your booter every time you recompile 
Ethan> the kernel, or keep the kernel in a nonstandard location.

	One does not need to recompile the booter, only rebuild the boot
file with new piggyback information.  If one piggybacks the kernel then
network booting becomes much simpler because the file loaded via BOOTP
contains all of the information to boot into the kernel.

David


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
