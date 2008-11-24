Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id 6FE1EDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 01:41:08 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so764284ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 06:41:06 -0800 (PST)
Message-ID: <fa686aa40811240641h1d7242feo7011f48adc2fa86a@mail.gmail.com>
Date: Mon, 24 Nov 2008 07:41:06 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <18730.8637.499133.778321@drongo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40811141120o2c0394daja732184aefaec901@mail.gmail.com>
	<18730.8637.499133.778321@drongo.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 23, 2008 at 8:38 PM, Paul Mackerras <paulus@samba.org> wrote:
> Grant Likely writes:
>
>> Please pull the 'merge' branch of my MPC5200 tree (url below).  I've
>
> Pulled and pushed out, but I will wait until Linus is back from
> vacation before asking him to pull.

Thanks Paul.

> Some of the commits in there are very close to being unsuitable to go
> in at this stage - in particular the ones that just fix up printks
> don't seem to me to be fixing a serious bug, build failure or
> regression.

Well, they do fixup compiler warnings which I would categorize under
build failure, otherwise I wouldn't have pushed them out.  I won't do
it again if that isn't sufficient.

>  However, we'll see what Linus says.

:-)

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
