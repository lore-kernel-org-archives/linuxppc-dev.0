Message-ID: <3B674930.EAD7ED1C@mvista.com>
Date: Tue, 31 Jul 2001 20:11:28 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Rod Boyce <rod_boyce@DMCWave.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Redirecting printk to a file
References: <9DCCE20055ACD311BBE200104B08D8340127490D@EXCHWENZ01>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rod Boyce wrote:

> We are having a bit of a quandary we are trying to redirect the output of
> printk

Don't assign a system console, or bump the loglevel real high.
Then just use the syslog daemon to move it from the kernel circular
buffer to a file.  This is all standard Linux stuff.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
