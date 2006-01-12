Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id 285F6681B4
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jan 2006 04:29:55 +1100 (EST)
Message-ID: <43C69130.2040409@ru.mvista.com>
Date: Thu, 12 Jan 2006 20:26:08 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: grant.likely@secretlab.ca
References: <1136795579724-git-send-email-grant.likely@secretlab.ca>
In-Reply-To: <1136795579724-git-send-email-grant.likely@secretlab.ca>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: glikely@gmail.com, dhlii@dlasys.net, gnathita@gmail.com,
	linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 01/10] Move xparameters.h into xilinx virtex device
 specific path
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

grant.likely@secretlab.ca wrote:
> xparameters should not be needed by anything but virtex platform code.
> Move it from include/asm-ppc/ to platforms/4xx/xparameters/
> 
> This is preparing for work to remove xparameters from the dependancy tree
> for most c files.  xparam changes should not cause a recompile of the world.
> Instead, drivers should get device info from the platform bus (populated
> by the boot code)
> 
> Signed-off-by: Grant C. Likely <grant.likely@secretlab.ca>


Tested on ML300: OK
