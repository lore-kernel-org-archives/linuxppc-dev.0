Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18730.8637.499133.778321@drongo.ozlabs.ibm.com>
Date: Mon, 24 Nov 2008 14:38:37 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <fa686aa40811141120o2c0394daja732184aefaec901@mail.gmail.com>
References: <fa686aa40811141120o2c0394daja732184aefaec901@mail.gmail.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> Please pull the 'merge' branch of my MPC5200 tree (url below).  I've

Pulled and pushed out, but I will wait until Linus is back from
vacation before asking him to pull.

Some of the commits in there are very close to being unsuitable to go
in at this stage - in particular the ones that just fix up printks
don't seem to me to be fixing a serious bug, build failure or
regression.  However, we'll see what Linus says.

Paul.
