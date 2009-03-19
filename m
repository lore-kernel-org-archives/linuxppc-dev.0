Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 074F8DDDF9
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 05:00:56 +1100 (EST)
Date: Thu, 19 Mar 2009 21:00:55 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH v4 0/4] Some PM-related patches for galak/powerpc.git next
Message-ID: <20090319180055.GA3155@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Li Yang <leoli@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 03:27:22PM -0500, Scott Wood wrote:
> Anton Vorontsov wrote:
>> On Wed, Mar 18, 2009 at 03:05:51PM -0500, Scott Wood wrote:
>>> Hmm, would that imply that the mdio underneath it is disabled as well?
>>
>> Technically, yes. In practice, MDIO and MAC drivers are probed
>> separately.
>
> Currently, yes, but that may not always be the case.
>
>> I don't see any better solution, should I just leave the core1's
>> mdio node intact?
>
> Probably.  It's not as if core1 is going to be putting ethernet@24000 to  
> sleep.

OK, so the updated patches no longer touch mpc8572ds_camp_core1.dts.


Other changes:

- Now the patch set depends on
  "fsl_pq_mdio: Use proper address translation"
  http://patchwork.ozlabs.org/patch/24698/

- Newly added gef_ppc9a board converted as well.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
