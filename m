Return-Path: <linux+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[78.32.30.218])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A030FB7C6A
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 20:15:56 +1100 (EST)
Date: Tue, 12 Jan 2010 09:01:49 +0000
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Francesco VIRLINZI <francesco.virlinzi@st.com>
Subject: Re: [RFC,PATCH 1/7 v2] Add a common struct clk
Message-ID: <20100112090149.GB26435@n2100.arm.linux.org.uk>
References: <1263279511.160551.332624337260.1.gpush@pororo>
	<4B4C376C.6080705@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4B4C376C.6080705@st.com>
Sender: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 12, 2010 at 09:48:44AM +0100, Francesco VIRLINZI wrote:
> Hi Jeremy
> In November I already sent a proposal on
>  a generic linux clk framework.
> On that I would suggest:
>
>>
>> +struct clk {
>> +	const struct clk_operations *ops;
>>    
>            spinlock_t lock;
>            const char *name;
>            int id;

Name and ID are totally pointless, unless you insist on using the clk
API in the wrong way (like S3C does.)
