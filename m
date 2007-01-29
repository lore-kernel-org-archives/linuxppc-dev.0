Return-Path: <maynardj@us.ibm.com>
Message-ID: <45BE4ED0.5030808@us.ibm.com>
Date: Mon, 29 Jan 2007 13:45:20 -0600
From: Maynard Johnson <maynardj@us.ibm.com>
MIME-Version: 1.0
To: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, oprofile-list@lists.sourceforge.net
Subject: [RFC, PATCH 0/4] Add support to OProfile for profiling Cell BE SPUs
	-- update
Content-Type: text/plain; charset=us-ascii; format=flowed
Reply-To: maynardj@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On December 14, 2006, I posted a patch that added support to the 
OProfile kernel driver for profiling Cell SPUs.  There have been some 
changes/fixes to this patch since the original posting (including 
forward porting from 2.6.18-based kernel to 2.6.20-rc1), so I am 
reposting the patch for review now.  This patch relies upon the 
following patches that have not been accepted yet:
   1. oprofile cleanup patch (submitted on Nov 27)
   2. Fix for PPU profiling (not submitted yet, since it depends on #1)
   3. SPU task notification patch (last submitted on Jan 26)

For those who may want to apply and build the oprofile SPU support 
patch, it would be necessary to first apply the above patches.  For 
convenience, I will post all three of the above patches, along with the 
oprofile SPU support patch.

Comments appreciated.

Thank you.

Maynard Johnson
IBM LTC Toolchain
