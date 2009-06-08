Return-Path: <avi@redhat.com>
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 549E2B70BB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  9 Jun 2009 02:05:28 +1000 (EST)
Message-ID: <4A2D33B8.3070908@redhat.com>
Date: Mon, 08 Jun 2009 18:52:24 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: mkimage for ppc
References: <4A24F20E.2020508@redhat.com>
	<1244476138.16253.22.camel@slate.austin.ibm.com>
In-Reply-To: <1244476138.16253.22.camel@slate.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: u-boot@lists.denx.de, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
>> But ppc wants a mkimage and I don't have one to give it.  Where 
>> can I find it?
>>     
>
> mkimage is a tool provided by u-boot
> (http://git.denx.de/cgi-bin/gitweb.cgi?p=u-boot.git;a=summary). IIRC
> people have discussed the need to include a copy in the kernel source in
> the past, but apparently nothing was ever done about it.
>   

I found git://scarlet.buici.com/uboot-mkimage a few days ago and it 
seems to work.

-- 
error compiling committee.c: too many arguments to function
