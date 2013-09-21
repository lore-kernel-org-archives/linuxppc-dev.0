Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 by ozlabs.org (Postfix) with ESMTP id BB3AA2C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 10:23:55 +1000 (EST)
Message-ID: <523CE716.70909@tabi.org>
Date: Fri, 20 Sep 2013 19:23:50 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/2][v3] powerpc/fsl-booke: Add initial T104x_QDS board
 support
References: <1379581205-24424-1-git-send-email-prabhakar@freescale.com>	
 <CAOZdJXVBV0LvEwTua_eyTHXJdOcHZKQCjiTrYocqfcQY5hosUw@mail.gmail.com>	
 <071A08F2C6A57E4E94D980ECA553F874F9CF8D@039-SN1MPN1-005.039d.mgd.msft.net>	
 <523BBC15.8030607@tabi.org> <523C0B78.7050005@freescale.com>	
 <523C37CF.3030103@tabi.org> <1379693218.16231.7.camel@aoeu.buserror.net>
In-Reply-To: <1379693218.16231.7.camel@aoeu.buserror.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Aggrwal Poonam-B10812 <B10812@freescale.com>,
 Jain Priyanka-B32167 <B32167@freescale.com>,
 Kushwaha Prabhakar-B32579 <B32579@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> The patch is not "lying".  It is describing the board, not what the
> patch supports.  This was something you used to constantly tell people
> to do...

The patch says:

	"DIU supports video at up to 1280x1024x32bpp"

How is this not misleading?

I understand that the patch describes the board, and that's correct.  It 
should also indicate which major functionality is not supported.  I was 
expecting something like this:

- Video
      - DIU hardware is capable of video up to 1280x1024x32bpp
      - DIU support is currently not implemented

> There are other things in that description that Linux doesn't do
> anything with, such as QIXIS.

Fair enough, but the QIXIS is not something that would generally be 
supported by Linux, as there is no "QIXIS driver".  There is a DIU 
driver, however.

The patch description should state which major components are not 
currently supported by software, but would be expected to be supported.
