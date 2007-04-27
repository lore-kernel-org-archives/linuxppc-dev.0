Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
Date: Fri, 27 Apr 2007 21:25:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: patches for 2.6.22
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have pushed out some more patches to the for-2.6.22 branch of the
powerpc.git repository.  I intend in the next couple of days to ask
Linus to pull that branch.

If anyone has patches that I haven't picked up yet which they think
should go into 2.6.22, please send me either a pointer to the
patches if previously posted to linuxppc-dev, or post them to
linuxppc-dev.  Note that I don't read linuxppc-embedded, and I rely on
platform maintainers to forward any patches that are ready for
inclusion to me and the linuxppc-dev list.

I'm willing to take arch/ppc patches that fix bugs or generally keep
the existing platforms there working.  I don't want to put large lumps
of new code in there, though.

Due to a mistake on my part (I put in the pasemi RNG driver) I have
had to rebase some of the patches in for-2.6.22 branch, so if you have
done a pull of the for-2.6.22 or master branches in the last 5 hours,
please do a pull -f to get the new set.

Paul.
