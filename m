Return-Path: <filippo.capurso@dave-tech.it>
Received: from dave-tech.it
	(host46-203-static.38-85-b.business.telecomitalia.it [85.38.203.46])
	by ozlabs.org (Postfix) with SMTP id D5DD167A42
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 17:14:52 +1000 (EST)
Message-ID: <4498F1E7.5010900@dave-tech.it>
Date: Wed, 21 Jun 2006 09:14:47 +0200
From: Filippo Capurso <filippo.capurso@dave-tech.it>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux on Virtex4
References: <821B2170E9E7F04FA38DF7EC21DE48710573FD21@VCAEXCH01.hq.corp.viasat.com>
	<528646bc0606191638j64448168ia19d6a97ab81e648@mail.gmail.com>
In-Reply-To: <528646bc0606191638j64448168ia19d6a97ab81e648@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Reply-To: filippo.capurso@dave-tech.it
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Grant,

I'm having some trouble with 2.6.17-rc6 kernel (wich incorporates your 
patches for Xilinx ML403 board) and my ML403 board.
This is my message about this issue:

http://ozlabs.org/pipermail/linuxppc-embedded/2006-June/023321.html

Could you help me please?
Thanks in advance.

Filippo Capurso

Grant Likely ha scritto:
> On 6/19/06, Martin, Tim <tim.martin@viasat.com> wrote:
> 
>>1) Is there anything obvious from the kernel panics below that I should
>>be looking for?  Just the answer "linux 2.4.20 is really fricken old,
>>upgrade" is probably the right answer.
> 
> 
> I've seen kernel panics when booting large kernel images (>1.5M),
> especially when I've welded the kernel image to a system.ace file for
> booting via CF.  I haven't tracked down the root cause.  I use both
> 2.4 and 2.6, and I've seen kernel panics with both.  In your case,
> you'll need to decode the backtrace to find out where the kernel is
> panicing
> 
> g.
> 

-- 

DAVE Srl - Electronics System House
via Forniz 2/1
33080 Porcia (PN) - Italy
Telephone: +39.0434.921215
Telefax: +39.0434.1994030
Freefax: +39.02.700520062
web: www.dave-tech.it
e-mail: filippo.capurso@dave-tech.it
how to reach us: http://mail.map24.com/dave
