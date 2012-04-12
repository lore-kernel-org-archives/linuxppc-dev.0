Return-Path: <jgpobox@gmail.com>
Sender: Jeff Garzik <jgpobox@gmail.com>
Message-ID: <4F873573.10406@pobox.com>
Date: Thu, 12 Apr 2012 16:05:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
References: <1333447938-16461-1-git-send-email-tqnguyen@apm.com>
 <4F7AE584.3050805@mvista.com>
In-Reply-To: <4F7AE584.3050805@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-ide@vger.kernel.org,
 "Thang Q. Nguyen" <tqnguyen@apm.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/03/2012 07:56 AM, Sergei Shtylyov wrote:
> Hello.
>
> On 03-04-2012 14:12, Thang Q. Nguyen wrote:
>
>> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
>> ---
>> Changes for v2:
>> - Use git rename feature to change the driver to the newname and for
>> easier review.
>
>> arch/powerpc/boot/dts/bluestone.dts | 21 +
>> drivers/ata/Makefile | 2 +-
>> drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} | 1371
>> ++++++++++++++--------
>> 3 files changed, 904 insertions(+), 490 deletions(-)
>> rename drivers/ata/{sata_dwc_460ex.c => sata_dwc_4xx.c} (56%)
>
> You submitted a magapatch doing several things at once (some even
> needlessly) and even in two areas of the kernel. This needs proper
> splitting/description.

Agreed...
