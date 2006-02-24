Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17406.20735.648880.979512@cargo.ozlabs.ibm.com>
Date: Fri, 24 Feb 2006 11:19:11 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Re: please pull powerpc-merge.git
In-Reply-To: <17405.42237.285728.981952@cargo.ozlabs.ibm.com>
References: <17405.42237.285728.981952@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please hold off from pulling powerpc-merge.git for now, if you haven't
already done the pull.  Stephen Rothwell has just convinced me that a
1-line change from Olaf Hering is in fact wrong, so I'll pull that
change out.  If you have pulled I'll just do a reverting commit.  (The
commit in question is 847db200a647058f6af883da3474b867617b7273.)

Paul.
