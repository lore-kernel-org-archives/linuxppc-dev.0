Message-ID: <3BF147CA.1080500@embeddededge.com>
Date: Tue, 13 Nov 2001 11:18:18 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Sarnath Kannan <sparc64@rediffmail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE in Mode 1 (Sandpoint) how ?
References: <20011113081739.29856.qmail@mailweb25.rediffmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sarnath Kannan wrote:


>   This means that all ISA interrupts are not
>   being routed properly. One more, I haven't
>   initialized the WinBond, coz reset values seem
>   meaninful. Could that be the reason for
>   this ?

Between the boot rom and Linux, the Winbond part is initialized
properly.  If you haven't removed any code, it should be fine.


> Is there any other switch, other than the S3,S4,S5,S6
> I need to worry about.

I forgot, is this an X2 or X3 (or X3b) version of the Sandpoint?


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
