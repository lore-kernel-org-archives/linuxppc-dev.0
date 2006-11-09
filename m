Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC,
	PATCH 2/2] Oprofile-on-Cell prereqs: Export hrtimer_forward
Date: Thu, 9 Nov 2006 19:14:50 +0100
References: <200611090858.11590.kevcorry@us.ibm.com>
	<200611090902.39714.kevcorry@us.ibm.com>
In-Reply-To: <200611090902.39714.kevcorry@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611091914.51783.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Kevin Corry <kevcorry@us.ibm.com>,
	oprofile-list@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 09 November 2006 16:02, Kevin Corry wrote:
> Add a symbol-export for kernel/hrtimer.c::hrtimer_forward(). This routine
> is needed by the upcoming Oprofile-for-Cell patches, since Oprofile can
> be built as a module.
> 
> Signed-Off-By: Kevin Corry <kevcorry@us.ibm.com>

Applied, thanks. I'll forward it along with the other patches when
the set is complete.

	Arnd <><
