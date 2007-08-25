Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18127.33141.119362.34178@cargo.ozlabs.ibm.com>
Date: Sat, 25 Aug 2007 11:10:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] fix undefined reference to device_power_up/resume
In-Reply-To: <20070824194201.GA8737@aepfle.de>
References: <20070824194201.GA8737@aepfle.de>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering writes:

> So change even more places from PM to PM_SLEEP to allow linking.

What config shows these errors?  I presume you need to have CONFIG_PM
but not CONFIG_PM_SLEEP in order to see them?

Paul.
