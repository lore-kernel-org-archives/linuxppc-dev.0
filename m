Message-Id: <200005151826.OAA26764@mal-ach.watson.ibm.com>
To: toa@pop.agri.ch
cc: Franz Sirl <Franz.Sirl@munich.netsurf.de>,
        Linux-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ppc assembler help needed 
In-Reply-To: Message from Andreas Tobler <toa@pop.agri.ch>
   of "Mon, 15 May 2000 20:26:26 +0200." <3920414A.8B3AC43B@pop.agri.ch>
Date: Mon, 15 May 2000 14:26:28 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Andreas Tobler writes:

Andreas> Franz Sirl wrote:
>> No, cmpw 0,r5,0 compares r5 to r0, use cmpwi 0,r5,0 to make a signed
>> compare of r5 against 0

Andreas> This works, thanks. The next question is automatically in the queue:

Andreas> all functions, insX/outsX in misc.S use this cmpw 0,r5,0, shouldn't it
Andreas> be a cmpwi 0,r5,0 then?

	Presumably all of the assembly functions want to compare against
an immediate value and should use cmpwi.

Andreas> BTW, does it mind which CPU is behind? In my case it's a 601.

	cmpwi is valid for all PowerPC processors, including 601.

David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
