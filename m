Return-Path: <dgibson@ozlabs.org>
Date: Tue, 4 Mar 2008 16:15:05 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: dtc: Make dt_from_blob() open its own file
Message-ID: <20080304051505.GD2757@localhost.localdomain>
References: <20080304051039.GC2757@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080304051039.GC2757@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 04, 2008 at 04:10:39PM +1100, David Gibson wrote:
> dt_from_source() and dt_from_fs() both take a filename (or directory
> name) argument and open files as necessary themselves.
> dt_from_blob(), however, expects the caller to open a file and pass it
> in.
> 
> This patch makes dt_from_blob() take a filename and open its own
> files, removing the inconsistency.  In addition, dt_from_blob() now
> correctly uses dtc_close_file() to close the file opened with
> dtc_open_file(), rather than directly calling fclose() on the
> contained FILE *.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Sorry, ignore.  There's a bug in this one, revised version coming.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
