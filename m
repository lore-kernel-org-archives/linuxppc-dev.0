Return-Path: <christian@riesch.at>
Message-ID: <4C9BC7CE.8020400@riesch.at>
Date: Thu, 23 Sep 2010 23:34:06 +0200
From: Christian Riesch <christian@riesch.at>
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
References: <cover.1285261533.git.richard.cochran@omicron.at>	<alpine.DEB.2.00.1009231238170.2962@router.home>	<1285268380.2587.11.camel@localhost.localdomain>	<alpine.DEB.2.00.1009231402420.2962@router.home>	<1285273684.2587.92.camel@localhost.localdomain>	<alpine.DEB.2.00.1009231533040.7522@router.home>
	<20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
In-Reply-To: <20100923223417.4ed62e5b@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
	linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alan Cox wrote:
>> It implies clock tuning in userspace for a potential sub microsecond
>> accurate clock. The clock accuracy will be limited by user space
>> latencies and noise. You wont be able to discipline the system clock
>> accurately.
> 
> Noise matters, latency doesn't. 

Well put! That's why we need hardware support for PTP timestamping to 
reduce the noise, but get along well with the clock servo that is 
steering the PHC in user space.

Christian
