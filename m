Return-Path: <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc/85xx: p1022ds: Use NULL instead of 0 for
 pointers
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1353385912-25882-1-git-send-email-tushar.behera@linaro.org>
Date: Sun, 25 Nov 2012 07:07:33 -0600
Message-Id: <CB1A6013-AB16-4373-86FC-844B6C48EC05@kernel.crashing.org>
References: <1353385912-25882-1-git-send-email-tushar.behera@linaro.org>
To: Tushar Behera <tushar.behera@linaro.org>
Cc: devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org,
 patches@linaro.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Nov 19, 2012, at 10:31 PM, Tushar Behera wrote:

> The third argument for of_get_property() is a pointer, hence pass
> NULL instead of 0.
> 
> Signed-off-by: Tushar Behera <tushar.behera@linaro.org>
> ---
> arch/powerpc/platforms/85xx/p1022_ds.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)

applied to next

- k
