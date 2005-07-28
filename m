Return-Path: <dan@embeddededge.com>
In-Reply-To: <6d145b42050728112919ab22b@mail.gmail.com>
References: <6d145b4205072809505b101b48@mail.gmail.com>
	<5367eda3a78096bb46168292371e9530@embeddededge.com>
	<6d145b42050728112919ab22b@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b961639b09e7a499874019c619d5aaca@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 28 Jul 2005 15:03:50 -0400
To: Prashant Alange <prashant.alange@gmail.com>
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: Problem allocating large meory using m8260_cpm_hostalloc
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 28, 2005, at 2:29 PM, Prashant Alange wrote:

> Could you pls tell me what function I should be using ....

Just look at some of the existing 82xx/CPM2 drivers, like
the SCC/FEC/FCC Ethernet.

> ..... I could not find the file DMA-API.txt file but
> I did get DMA-mapping.txt. Is this the file you were referring to?

Ugh ...  a newer kernel would help.  The DMA-mapping.txt doesn't
apply to the local CPM devices, so just look at some existing drivers.

Thanks.


	-- Dan
