Return-Path: <grant.likely@secretlab.ca>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by ozlabs.org (Postfix) with ESMTP id BA221B70CB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 23:48:50 +1000 (EST)
Received: by fxm2 with SMTP id 2so1850109fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 06:48:46 -0700 (PDT)
Sender: Grant Likely <glikely@secretlab.ca>
References: <19611.16302.262307.129176@pilspetsen.it.uu.se>
	<20100923113807.4643fbbb.rdunlap@xenotime.net>
	<19611.46496.782340.466509@pilspetsen.it.uu.se>
	<20100923150559.9c67da11.rdunlap@xenotime.net>
	<20100924111209.3c071da3@endymion.delvare>
	<19612.33369.175358.879889@pilspetsen.it.uu.se>
	<20100924133932.4320b993@endymion.delvare>
In-Reply-To: <20100924133932.4320b993@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Subject: Re: [BUG 2.6.36-rc5] of_i2c.ko <-> i2c-core.ko dependency loop
From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 24 Sep 2010 07:48:38 -0600
To: Jean Delvare <khali@linux-fr.org>,Mikael Pettersson <mikpe@it.uu.se>
Message-ID: <f1f37e21-f04a-4fef-868c-27c7d2ebe594@email.android.com>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



"Jean Delvare" <khali@linux-fr.org> wrote:

>Hi Mikael,
>
>On Fri, 24 Sep 2010 12:50:01 +0200, Mikael Pettersson wrote:
>> Jean Delvare writes:
>>  > As far as I can see this is caused by this commit from Grant:
>>  > 
>>  > http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5
>>  > 
>>  > Mikael, can you please try reverting this patch and see if it solves
>>  > your problem?
>> 
>> Yes, reverting the above commit from 2.6.36-rc5 eliminated the warnings,
>> and I was able to insmod the i2c-{core,dev,powermac}.ko modules.
>
>Thanks for testing and reporting. Grant, unless you come up with a fix
>very quickly, I'll have to revert
>959e85f7751c33d1a2dabc5cc3fe2ed0db7052e5 for 2.6.36.

I'll get a fix out today.
g.

>
>-- 
>Jean Delvare

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
