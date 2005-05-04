Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17017.16478.767293.191940@cargo.ozlabs.ibm.com>
Date: Thu, 5 May 2005 07:36:30 +1000
From: Paul Mackerras <paulus@samba.org>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <466e699745cf24e660e296530f6e34dc@embeddededge.com>
References: <17016.29775.224816.691409@cargo.ozlabs.ibm.com>
	<466e699745cf24e660e296530f6e34dc@embeddededge.com>
Cc: linuxppc-dev@ozlabs.org, trini@kernel.crashing.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dan Malek writes:

> What about cores that aren't CONFIG_6xx (8xx, 4xx, e500, etc.)?

Well, what about them?  I didn't change anything for them (except to
remove the -mstring).  What -mcpu or -mtune options do you want for them?

> How about we create a CONFIG_GCC_CPUOPT and
> CONFIG_AS_OPT, and just get these out of the configuration file?

No.  We already have enough configuration questions that are
unanswerable by ordinary mortals.

Paul.
