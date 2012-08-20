Return-Path: <leonid@extricom.com>
Message-ID: <50323670.1050209@extricom.com>
Date: Mon, 20 Aug 2012 16:06:56 +0300
From: leonid <leonid@extricom.com>
MIME-Version: 1.0
To: Linuxppc-dev@lists.ozlabs.org
Subject: myri10ge in p4080ds ppc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi
This is my first mail in this group , so I hope this is the right place 
for it.

I am testing myri10ge pci-e (10G ethernet card) on p4080(freescale 
powerpc) evaluation board.
using kernel 2.6.34.6
when I am trying to insert myri10ge kernel module, I getting :
"myri10ge: Version 1.5.2-1.459
myri10ge 0001:03:00.0: invalid sram_size -33B or board span 16777216B "

it is looks like sram_size value is garbage read from the device .

any idea ?

reference:
myri10ge - https://www.myricom.com
p4080ds - 
http://www.freescale.com/webapp/sps/site/prod_summary.jsp?code=P4080DS
-- 
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at http://vger.kernel.org/majordomo-info.html
Please read the FAQ at http://www.tux.org/lkml/
