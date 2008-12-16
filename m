Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 7D4A6DDF5F
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Dec 2008 03:38:35 +1100 (EST)
Date: Tue, 16 Dec 2008 19:38:33 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: More commits added to powerpc.git next and master branches
Message-ID: <20081216163833.GA22368@oksana.dev.rtsoft.ru>
References: <18759.14410.731000.378702@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <18759.14410.731000.378702@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

On Tue, Dec 16, 2008 at 04:10:34PM +1100, Paul Mackerras wrote:
> I have added the following commits to the next and master branches of
> my powerpc.git tree (including commits pulled from Kumar's tree).  I
> have also pulled in Linus' current tree and the 3 commits that I just
> asked him to pull.

Is there anything wrong with these down below?

[1/3] of: Minor simplification for the of_parse_phandles_with_args()
http://patchwork.ozlabs.org/patch/12449/

[2/3] of: of_parse_phandles_with_args() learns to differentiate 'hole' cells
http://patchwork.ozlabs.org/patch/12450/

[3/3] of/gpio: Implement of_gpio_count()
http://patchwork.ozlabs.org/patch/12451/

Can we apply them for 2.6.29?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
