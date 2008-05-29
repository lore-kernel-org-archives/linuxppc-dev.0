Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20080529061621.GA7220@yookeroo.seuss>
References: <20080529061621.GA7220@yookeroo.seuss>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <e949c0c4cdc3aa5ca462378b4d04709e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: dtc: Remove some small bashisms from test scripts
Date: Thu, 29 May 2008 14:28:12 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Some of the helper scripts used to run testcases contain some
> constructs that are bashisms.  Or at least which don't work on dash,
> the minimal shell used as /bin/sh on recent Ubuntu systems.

Both of these (the >& redirection, and "source" searching the current
directory if the script isn't found in $PATH) are indeed bashisms.

This patch looks good to me.


Segher
