Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <1189748800.165997.810365539433.2.gpush@pokey>
References: <1189748800.165997.810365539433.2.gpush@pokey>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11C5F6D9-7520-4DEE-A061-648A377DCB6D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/2] fsl/embedded6xx: don't cast the result of
	of_get_property
Date: Tue, 25 Sep 2007 15:27:30 -0500
To: Jeremy Kerr <jk@ozlabs.org>
Cc: PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 14, 2007, at 12:46 AM, Jeremy Kerr wrote:

> Use a temporary variable of the correct type instead.
>
> Also, this allows us to check the return value in ls_uarts_init, to
> avoid dereferencing a null pointer if required properties aren't
> present.
>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Can I get you to respin this against for-2.6.24.  For some reason  
this doesn't apply cleanly for me.

- k
