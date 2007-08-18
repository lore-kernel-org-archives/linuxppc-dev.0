Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18118.41979.148016.177427@cargo.ozlabs.ibm.com>
Date: Sat, 18 Aug 2007 17:47:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andreas Schwab <schwab@suse.de>
Subject: Re: 2.6.23-rc3 broken on G5
In-Reply-To: <jefy2j6qtq.fsf@sykes.suse.de>
References: <jelkccftt6.fsf@sykes.suse.de>
	<18116.52843.212978.281399@cargo.ozlabs.ibm.com>
	<jefy2j6qtq.fsf@sykes.suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab writes:

> It's a dual 1.8GHz.  Config is attached.

OK, your config works on my dual G5 (if I build in the SCSI disk
driver and the sata_svw driver so it can find my root patition).

How much RAM does your machine have?

Paul.
