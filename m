Return-Path: <glikely@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id AEFF267BAC
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Sep 2006 06:41:57 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id 30so202937ugc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 28 Sep 2006 13:41:55 -0700 (PDT)
Message-ID: <528646bc0609281341w6946d4c6ra326aca505e15d7c@mail.gmail.com>
Date: Thu, 28 Sep 2006 14:41:55 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Pradeep Sampath" <pradeepsampath@yahoo.com>
Subject: Re: Linux BSP on linux kernel 2.6
In-Reply-To: <20060928202450.82132.qmail@web83204.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <20060928202450.82132.qmail@web83204.mail.mud.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 9/28/06, Pradeep Sampath <pradeepsampath@yahoo.com> wrote:
> Hi All,
>
> I am new to hardware design and in general embedded development. I am trying
> to run linux kernel 2.6 on a Xilinx ML403 dev board. I followed the steps
> indicated by Ameet Patil -
> http://www.linux.get2knowmore.com/2006/06/30/quick-guide-linux-26-on-xilinx-virtex-ii-pro-boards-part-i/.
> When I bootup the dev board from compact flash nothing shows up on the
> serial terminal. But i see the flash download complete on the LCD display.

Your new system.ace should not display anything on the LCD.  Double
check your SysACE config dip switches on the board.

Alternately, clear out the DOS partition of your CF card and put
nothing on it except your new system.ace.  That way you know that
you're not inadvertently booting the wrong .ace file.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
