Message-ID: <3C9F9892.7080704@embeddededge.com>
Date: Mon, 25 Mar 2002 16:37:22 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Neil Horman <nhorman@lvl7.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: question regarding organization of the pte hash table
References: <3C9E2500.4477166B@lvl7.com> <3C9F6E67.2030503@embeddededge.com> <3C9F7270.AE56A23@lvl7.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Neil Horman wrote:


> ....then do we reconstruct pte's on the fly

I guess you could say that.  The PTEs stored in the Linux page tables are
in the proper format to be loaded into the TLBs, so there is little
"reconstruction" required.  This coupled with the hardware support makes
the job fairly painless.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
