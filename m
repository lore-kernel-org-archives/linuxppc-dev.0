Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sY6Mq65GlzDsNM
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 11:21:43 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Scott Wood <scott.wood@nxp.com>, Andy Fleming <afleming@gmail.com>
Cc: "scottwood\@freescale.com" <scottwood@freescale.com>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "aperez\@alexperez.com" <aperez@alexperez.com>
Subject: Re: [PATCH 3/3] Cyrus: create a defconfig
In-Reply-To: <DB5PR0401MB19281D6D9CFE4352E21E57A091FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-4-git-send-email-afleming@gmail.com>
 <DB5PR0401MB1928F23FDFF08F9E1288365691F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd7kKSyg4Ksn8=T9q6308LNBvRH+YqLcAMqqh=-tqEEy7w@mail.gmail.com>
 <DB5PR0401MB19281D6D9CFE4352E21E57A091FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Date: Tue, 13 Sep 2016 11:21:43 +1000
Message-ID: <87vay0ppaw.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scott.wood@nxp.com> writes:
> On 09/10/2016 05:12 PM, Andy Fleming wrote:
>> On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com
>> <mailto:scott.wood@nxp.com>> wrote:
>>     On 09/06/2016 02:12 PM, Andy Fleming wrote:
>>     > +CONFIG_EXT3_FS=y
>> 
>>     This has nothing to do with power/reset, and is already present in
>>     fsl-emb-nonhw.config.
>> 
>> 
>>     Ok, weird. Are you sure? I see:
>> 
>> 
>>         # CONFIG_EXT3_FS is not set
>> 
>>         CONFIG_EXT4_FS=y
>
> Apparently it was just removed by commit
> bdd910017c6a4 ("powerpc/configs: Remove old symbols from defconfigs").
>
> Andrew Donnellan, why was ext3 support removed?

Because ext3 was removed, ext4 handles it now.

The EXT3 Kconfig symbols still exist but they are just for backward
compat with old configs (like this one), and they just turn on EXT4.

So AFAICS Andrew's patch was correct, and you should be getting ext3
support from ext4.

cheers
