Return-Path: <jeff@garzik.org>
Message-ID: <4656033F.1060505@garzik.org>
Date: Thu, 24 May 2007 17:27:27 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 2/10] spidernet: beautify error messages
References: <20070522230942.GT5921@austin.ibm.com>
	<20070522231354.GA2147@austin.ibm.com>
In-Reply-To: <20070522231354.GA2147@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, netdev@vger.kernel.org,
	Florin Malita <fmalita@gmail.com>, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> Make error messages print which interface they apply to.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> ----
>  drivers/net/spider_net.c |   10 ++++++----
>  drivers/net/spider_net.h |    2 +-
>  2 files changed, 7 insertions(+), 5 deletions(-)

applied 2-10 to #upstream (2.6.23)
