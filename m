Message-ID: <3CB45F5F.20400@embeddededge.com>
Date: Wed, 10 Apr 2002 11:50:55 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F92@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:


> IMHO, I prefer the way it is handled in 2.4.18.

Ahhhh.....I see now.  It took some time to get the _devel
updates into the stable tree.  The spurious interrupt is
an artifact of the 8260 code not updated to match Ben's
generic PPC changes.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
