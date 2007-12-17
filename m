Return-Path: <jwboyer@linux.vnet.ibm.com>
Date: Mon, 17 Dec 2007 17:54:21 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] holly.c: Remove unneccessary include of
	linux/ide.h
Message-ID: <20071217175421.065d1cda@zod.rchland.ibm.com>
In-Reply-To: <20071217230434.GB22779@lixom.net>
References: <20071217230434.GB22779@lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 17 Dec 2007 17:04:34 -0600
Olof Johansson <olof@lixom.net> wrote:

> There's nothing in holly.c that needs linux/ide.h, just remove it from
> the list of includes.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
