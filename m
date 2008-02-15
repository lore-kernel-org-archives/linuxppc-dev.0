Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 26122DE651
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Feb 2008 05:44:33 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so368083anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Feb 2008 10:44:31 -0800 (PST)
Message-ID: <fa686aa40802151044pd118fe2n2ed008a9a7a8176f@mail.gmail.com>
Date: Fri, 15 Feb 2008 11:44:31 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: rodolfo <rodolfo@lesc.ufc.br>
Subject: Re: XUP Virtex II p with Linux 2.4 - Question
In-Reply-To: <1575591b2b88bb7caca70587ec899dea@lesc.ufc.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1575591b2b88bb7caca70587ec899dea@lesc.ufc.br>
Cc: rodolfogalvao87@gmail.com, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Feb 15, 2008 at 8:51 AM, rodolfo <rodolfo@lesc.ufc.br> wrote:
> Hi everybody!
>
>  I subscribe on this list today because i have some problems with linux
>  kernel 2.4 compilation. I'm using EDK/ISE 9.1i, crosstool-0.38 . I follow
>  this sites:
>
<snip>
>
>  Anybody can help me? i'm new in this world (fpga - linux)!

You should switch to using a 2.6 kernel.  The 2.4 stuff is difficult to support.

See my notes here:

http://wiki.secretlab.ca/index.php/Linux_on_Xilinx_Virtex

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
