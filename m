Message-ID: <3D46E96B.1020504@dslextreme.com>
Date: Tue, 30 Jul 2002 12:30:51 -0700
From: akuster <akuster@dslextreme.com>
Reply-To: akuster@dslextreme.com
MIME-Version: 1.0
To: Hollis Blanchard <hollis@austin.ibm.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: __cli on 4xx - MSR:CE?
References: <1028054814.13540.131.camel@granite.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hollis Blanchard wrote:
> Shouldn't __cli on 4xx disable the MSR CE bit as well as EE?
>
> -Hollis
>
>
>
>
>
>

It should.  Critical interrupts are currently not enabled in the kernel

armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
