Message-ID: <3D947EF3.7010800@embeddededge.com>
Date: Fri, 27 Sep 2002 11:53:23 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: acurtis@onz.com
Cc: Sylvain Latulippe <slatulippe@mediatrix.com>,
	"'Michael Thompson'" <mickey@berkeley.innomedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Are 8260 and 8250 CPM interface compatible?
References: <NCBBIINEHIPFGJPLBEIFGEJJDMAA.acurtis@onz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Allen Curtis wrote:

> Considering that Motorola is now using the CPM in multiple processors, including DSPs, would it make sense to breakout the support from the 8260 implementation and make it an independent option like PCI?

It would be reasonable, but I don't want to start that until we have another
processor port in the works that also requires it.  Simply changing all of
this for the sake of doing so with grand plans how it can be used anywhere
isn't a useful way to use our resources.  I particularly don't like change
for the sake of change, because it makes it difficult for us that rely
on things to work, and I really want to avoid a mess like 4xx OCP :-).

Thanks.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
