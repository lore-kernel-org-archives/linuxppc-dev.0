Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Subject: Re: starting with 2.6.26-rc1 cell_defconfig fails on QS22
Date: Tue, 24 Jun 2008 09:45:32 +1000
References: <20080623094539.GA16685@lisas.de>
In-Reply-To: <20080623094539.GA16685@lisas.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806240945.33255.jk@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Adrian,

> Somehow I expect that I am doing something wrong, because nobody else
> has reported something like this yet.

Seems to work fine here - just booted 945754a on a QS22 with 
cell_defconfig:

[jk@qs22 ~]$ cat /proc/version
Linux version 2.6.26-rc7-09992-g945754a (jk@build) (gcc version 4.1.3 
20080114 (prerelease) (Debian 4.1.2-19)) #154 SMP Tue Jun 24 09:32:59 
EST 2008

Reverting that commit definitely fixes the problem for you? Perhaps a 
binutils problem then?

Cheers,


Jeremy
