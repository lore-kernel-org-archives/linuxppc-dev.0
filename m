Return-Path: <larry.finger@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xt0SW4brNzDqlR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 10:55:23 +1000 (AEST)
Received: by mail-io0-x229.google.com with SMTP id n69so11104605ioi.5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Sep 2017 17:55:23 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: Regression for Power PC in 4.14-rc0 - bisected to commit
 31bfdb036f12
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
References: <201709140009.v8E08n9S024108@mx0a-001b2d01.pphosted.com>
 <77fb14dd-26d5-a647-bed1-142d56d26374@au1.ibm.com>
From: Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <cc4ee203-0224-91e3-ef60-7180dfb275ce@lwfinger.net>
Date: Wed, 13 Sep 2017 19:55:20 -0500
MIME-Version: 1.0
In-Reply-To: <77fb14dd-26d5-a647-bed1-142d56d26374@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/2017 07:37 PM, Andrew Donnellan wrote:
> On 14/09/17 10:07, Larry Finger wrote:
>> When booting my PowerBook Aluminum G4, I get a pop-up screen that says "The 
>> system is running in low-graphics  mode. Your screen, graphics card, and input 
>> device settings could not be detected correctly. You will need to configure 
>> these yourself." This is a big-endian 74xx CPU. The lscpu command says it is a 
>> PowerBook5,6 model.
>>
>> This problem has been bisected to commit 31bfdb036f12 ("powerpc: Use 
>> instruction emulation infrastructure to handle alignment faults"). I am 
>> confident of the accuracy of the bisection.
>>
>> Attached is the configuration.
> 
> Try with https://patchwork.ozlabs.org/patch/813153/
> 
> (A selftest for the instruction emulation will make its way upstream eventually...)

That patch does fix my problem. Thanks for the quick response.

Larry
