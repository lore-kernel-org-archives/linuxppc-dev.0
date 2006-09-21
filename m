Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17682.31316.789800.611166@cargo.ozlabs.ibm.com>
Date: Thu, 21 Sep 2006 21:41:08 +1000
From: Paul Mackerras <paulus@samba.org>
To: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: First cut of "wrapper" program
In-Reply-To: <45127177.3000408@hogyros.de>
References: <17681.53490.705075.155580@cargo.ozlabs.ibm.com>
	<45127177.3000408@hogyros.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Simon Richter writes:

> Hmm, in Debian there is a tool called mkvmlinuz that does this, which is
> run in a hook script after generating an initrd.

It doesn't handle any of the embedded formats (uImage, treeboot,
etc.).  Neither does my script, but it will...  It also doesn't handle
including a device-tree blob.

Paul.
