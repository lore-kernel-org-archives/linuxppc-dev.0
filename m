Message-Id: <m117a3x-0000WZC@tri-yann.crf.canon.fr>
Date: Fri, 23 Jul 1999 09:48:13 +0200 (CEST)
From: "VALETTE Eric" <valette@crf.canon.fr>
To: Paul.Mackerras@cs.anu.edu.au
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <199907230241.MAA25100@tango.anu.edu.au> (message from Paul
	Mackerras on Fri, 23 Jul 1999 12:41:51 +1000)
Subject: Re: Is the vger 2.2 kernel branch dead
References: <Pine.LNX.4.10.9907221012590.18625-100000@mercator.cs.kuleuven.ac.be> <m117EQ0-0000WZC@tri-yann.crf.canon.fr> <199907230241.MAA25100@tango.anu.edu.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> VALETTE Eric <valette@crf.canon.fr> wrote:
>> So why did I get no single comment on patches I submitted?
>> The Prep IDE handling is broken...

Paul> The trouble is that "PReP" is such an ill-defined idea.  I was
Paul> interested to see your patch, but I assume that some other PReP
Paul> machines need it the way it is without your patch.

Without the patch you can still install and run linux
from PPCBUG using the Network BOot command (NBO) and using
local IDE disks but you fail to use the "pboot;a" booting 
directly from hard disk (or at power on)...

AND more annoying, of course you must reinstall your disk
if you formatted it using the non correct ide byte swap handling

-- eric

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
