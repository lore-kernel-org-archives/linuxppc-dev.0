Message-ID: <3CB48582.5030502@embeddededge.com>
Date: Wed, 10 Apr 2002 14:33:38 -0400
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 8260 - Spurious interrupt when calling __sti()
References: <F1BED55F35F4D3118C0F00E0295CFF4DFF9F95@mail.mediatrix.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Jean-Denis Boyer wrote:


> However, this apparent 'out of sync' has nothing to do
> with the fact that the invalid interrupt pops up, right ?

If it happens only once at boot, there must be some device
with a dangling interrupt not properly initialized.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
