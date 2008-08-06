Return-Path: <rene@exactcode.de>
Received: from mr01.hansenet.de (mr01.hansenet.de [213.191.74.10])
	by ozlabs.org (Postfix) with ESMTP id E0EC9DDFDC
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 04:05:01 +1000 (EST)
Message-ID: <4899E2D9.4010506@exactcode.de>
Date: Wed, 06 Aug 2008 19:43:53 +0200
From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@exactcode.de>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: Big include file move breaks user mode
References: <20080805120916.2f39307c@lappy.seanm.ca>	<200808061651.40361.arnd@arndb.de>
	<20080806110124.40280d13@lappy.seanm.ca>
In-Reply-To: <20080806110124.40280d13@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

Sean MacLennan wrote:
> On Wed, 6 Aug 2008 16:51:40 +0200
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>
>   
>> The user space headers are provided by your distribution, not
>> by the kernel, so include/asm should be a directory, not a symlink.
>> If you are building your own distro, don't just copy the files
>> but rather use 'make headers_install' to get a sanitized version.
>>     
>
> Sorry, I forgot to reply to the list :( Kumar mentioned the "make
> headers_install" and I got it working with our build system. So
> everything is back on track.
>   
Heh, you might also consider using "off the shelf" build systems, such
as the T2 SDE:

  http://t2-project.org

To avoid re-inventing the whell again and again.

Yours,

-- 
  René Rebe - ExactCODE GmbH - Europe, Germany, Berlin
  http://exactcode.de | http://t2-project.org | http://rene.rebe.name
