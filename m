Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18536.26913.342478.867665@cargo.ozlabs.ibm.com>
Date: Mon, 30 Jun 2008 15:03:29 +1000
From: Paul Mackerras <paulus@samba.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2] powerpc/bootwrapper: Add documentation of boot wrapper
	targets
In-Reply-To: <20080628050407.6067.90225.stgit@trillian.secretlab.ca>
References: <20080628050407.6067.90225.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, john.linn@xilinx.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely writes:

> From: Grant Likely <grant.likely@secretlab.ca>
> 
> There have been many questions on and off the mailing list about how
> exactly the bootwrapper is used for embedded targets.  Add some
> documentation and help text to try and clarify the system.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>

...

> diff --git a/arch/powerpc/boot/wrapper b/arch/powerpc/boot/wrapper
> index d6c96d9..7cd4182 100755
> --- a/arch/powerpc/boot/wrapper
> +++ b/arch/powerpc/boot/wrapper
> @@ -203,6 +203,10 @@ simpleboot-virtex405-*)
>      platformo="$object/virtex405-head.o $object/simpleboot.o"
>      binary=y
>      ;;
> +simpleboot-*)
> +    platformo="$object/simpleboot.o"
> +    binary=y
> +    ;;
>  esac

Evidently your patch does more than just "Add documentation"...

Paul.
