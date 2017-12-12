Return-Path: <geoff@infradead.org>
Subject: Re: Getting kernel 4.14 to run on PS3
To: Nathan Whitehorn <nwhitehorn@freebsd.org>,
 Sascha Schroeder <sascha.schroeder@aethyx.com>
Cc: Linuxppc-dev@lists.ozlabs.org, petitboot@lists.ozlabs.org
References: <9621b73a-12e0-1254-932c-2456238b5526@aethyx.com>
 <1dd3a437-a20e-c808-749c-4cdb7b9d3675@infradead.org>
 <4dadeca5-22dc-6ab1-961e-8f989b6f8699@freebsd.org>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <5c41fd34-5aac-028e-af12-59b6ab576d91@infradead.org>
Date: Tue, 12 Dec 2017 15:05:39 -0800
MIME-Version: 1.0
In-Reply-To: <4dadeca5-22dc-6ab1-961e-8f989b6f8699@freebsd.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nathan,

On 12/08/2017 01:25 PM, Nathan Whitehorn wrote:
> I submitted patches to libfdt that resolve this particular ABI breakage yesterday. If the patch gets merged, newer kernels should become bootable again.

Here's the link:

  https://github.com/dgibson/dtc/pull/12 (Add limited read-only support for older (V2 and V3) device tree to libfdt.)

I rebased your patch and have it in my ps3-queue
branch, but my ps3 with ps3-petitboot-09.11.30 still
would not boot with it.  I didn't spend any time yet
to look into why.

  https://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git/log/?h=ps3-queue

-Geoff
