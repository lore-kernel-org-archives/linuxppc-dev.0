Date: Mon, 12 Jul 1999 15:23:43 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: Netbooting Linux on an iMac
In-reply-to: <9907112303.AA25560@marc.watson.ibm.com>
To: David Edelsohn <dje@watson.ibm.COM>
Cc: "Charles A. Jolley" <charles.jolley@zeratec.com>,
        linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990712152028.539449537E-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


If you do get some kernels that OF accepts, please tell the rest of the
world how! I don't wanna have to you MacOS just to load Linux on my next
machine (fake toddler tantrum)...

I would be about ready to go Linux-only if it weren't for that
uncertainty. I can OF-boot my current beige G3, but... doesn't look
hopeful. Net box may have to be something else... darn, mac-on-linux
with VPC has such I high cool hack value (if I could figure out why VPC
thinks I've mis-installed it).

On Sun, 11 Jul 1999, David Edelsohn wrote:

> 
> 	Please look in the archive of this mailinglist where you will find
> a detailed answer from me about exactly what an OpenFirmware boot image
> must look like to be recognized and loaded.  It basically is a 32-bit
> PowerPC ELF image with a special NOTE section and the loader section in
> the header referencing the NOTE section.
> 
> David

> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
