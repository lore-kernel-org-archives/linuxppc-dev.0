Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18520.42844.509290.191269@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2008 16:12:44 +1000
From: Paul Mackerras <paulus@samba.org>
To: Eric B Munson <ebmunson@us.ibm.com>
Subject: Re: [RFC PATCH] Keep 3 high personality bytes across exec
In-Reply-To: <20080618060651.GA8251@us.ibm.com>
References: <20080618060651.GA8251@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Eric B Munson writes:

> Currently when a 32 bit process is exec'd on a powerpc 64 bit host the values
> of the top three bytes of the personality are clobbered.  This patch adds a
> check in the SET_PERSONALITY macro that will carry all the values in the top
> three bytes across the exec.
> 
> Signed-off-by: Eric B Munson <ebmunson@us.ibm.com>

Your commit message needs to remind us what is in those bytes, and
tell us what bad things happen if we don't keep them, and what is the
benefit of keeping them.  And if there are any user-visible aspects of
this change, they need to be flagged.

Paul.
