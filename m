From: linas@austin.ibm.com
Date: Thu, 10 Jul 2003 12:17:33 -0500
To: maurie <maurie@risc.sps.mot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linuxppc 8245 lost interrupt
Message-ID: <20030710121733.B41788@forte.austin.ibm.com>
References: <000101c346ee$46545ac0$9b7c520a@sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <000101c346ee$46545ac0$9b7c520a@sps.mot.com>; from maurie@risc.sps.mot.com on Thu, Jul 10, 2003 at 09:19:28AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jul 10, 2003 at 09:19:28AM -0500, maurie wrote:
>
> 	I am using kernel 2.4.21-rc1.

Please try another one of the kernels.  There were several ide-related
ppc64 bugs; I am currently confused about which ones got fixed when
(or if they are fixed yet).  I breifly saw the lost-irq bug, but it
went away for me, not sure why.

--linas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
